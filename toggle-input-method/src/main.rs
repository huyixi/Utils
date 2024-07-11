use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};
use std::process::Command;

fn main() -> io::Result<()> {
    let file_path = "/Users/huyixi/Library/Rime/default.yaml";

    // Open the file and read its contents into a vector of lines
    let file = File::open(file_path)?;
    let reader = BufReader::new(file);
    let mut lines: Vec<String> = reader.lines().collect::<Result<_, _>>()?;

    // Define the substring to search for
    let target_substring = "double_pinyin_flypy";
    let mut toggled_comment = false;

    // Iterate through the lines to find and toggle the line containing the target substring
    for line in &mut lines {
        if line.contains(target_substring) {
            if line.trim().starts_with("#") {
                *line = line.trim_start_matches('#').trim_start().to_string();
                println!("Supports both English and Chinese input methods: {}", line);
            } else {
                *line = format!("# {}", line);
                println!("Supports only English input method: {}", line);
            }
            toggled_comment = true;
            break;
        }
    }

    if !toggled_comment {
        println!(
            "No line found containing the substring: {}",
            target_substring
        );
    }

    // Write the modified lines back to the file
    let mut file = File::create(file_path)?;
    for line in lines {
        writeln!(file, "{}", line)?;
    }

    // Print the instruction to the user
    println!("If change failed, press \x1b[1mControl-Option-`\x1b[0m to deploy the changes.");

    // Run AppleScript to simulate pressing Control-Option-`
    let script = r#"
        tell application "System Events"
            keystroke "`" using {control down, option down}
        end tell
    "#;

    let output = Command::new("osascript").arg("-e").arg(script).output();

    match output {
        Ok(output) => {
            if !output.status.success() {
                eprintln!(
                    "Error running AppleScript: {}",
                    String::from_utf8_lossy(&output.stderr)
                );
            }
        }
        Err(e) => {
            eprintln!("Failed to run AppleScript: {}", e);
        }
    }

    Ok(())
}
