use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};

fn main() -> io::Result<()> {
    let file_path = "/Users/huyixi/Library/Rime/default.yaml";

    // Open the file and read its contents into a vector of lines
    let file = File::open(file_path)?;
    let reader = BufReader::new(file);
    let mut lines: Vec<String> = reader.lines().collect::<Result<_, _>>()?;

    // Define the substring to search for
    let target_substring = "double_pinyin_flypy";

    // Iterate through the lines to find and toggle the line containing the target substring
    for line in &mut lines {
        if line.contains(target_substring) {
            if line.trim().starts_with("#") {
                *line = line.trim_start_matches('#').trim_start().to_string();
            } else {
                *line = format!("# {}", line);
            }
            break;
        }
    }

    // Write the modified lines back to the file
    let mut file = File::create(file_path)?;
    for line in lines {
        writeln!(file, "{}", line)?;
    }

    println!(
        "Comment toggled for the line containing: {}",
        target_substring
    );

    Ok(())
}
