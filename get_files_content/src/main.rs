use std::env;
use std::fs::{self, File};
use std::io::{self, Read, Write};
use std::path::Path;

fn main() -> io::Result<()> {
    // Get the folder path from the command line arguments or use the current directory if none is provided
    let args: Vec<String> = env::args().collect();
    let folder_path = if args.len() == 2 { &args[1] } else { "." };

    // Get the folder name to use in the output file name
    let folder_name = Path::new(folder_path)
        .file_name()
        .unwrap_or_else(|| Path::new(folder_path).as_os_str())
        .to_str()
        .expect("Invalid folder name")
        .to_string();

    // Determine the output file path
    let output_folder = if folder_path.is_empty() {
        "."
    } else {
        folder_path
    };
    let output_file_path = format!("{}/{}_output.txt", output_folder, folder_name);

    // Create the output file
    let mut output_file = File::create(&output_file_path)?;

    // Default list of files to ignore
    let ignore_files = vec![".DS_Store"];
    let mut unreadable_files = Vec::new();

    // Recursively walk through the folder and read each file
    fn visit_dirs(
        dir: &Path,
        output_file: &mut File,
        ignore_files: &Vec<&str>,
        unreadable_files: &mut Vec<String>,
    ) -> io::Result<()> {
        if dir.is_dir() {
            for entry in fs::read_dir(dir)? {
                let entry = entry?;
                let path = entry.path();

                println!("Processing path: {:?}", path); // Debug: print each path being processed

                if path.is_dir() {
                    visit_dirs(&path, output_file, ignore_files, unreadable_files)?;
                } else if path.is_file() {
                    let file_name = path.file_name().unwrap().to_str().unwrap();

                    // Skip files in the ignore list
                    if ignore_files.contains(&file_name) {
                        println!("Ignoring file: {}", file_name); // Debug: print ignored file
                        continue;
                    }

                    println!("Reading file: {}", file_name); // Debug: print each file being read

                    match File::open(&path) {
                        Ok(mut file) => {
                            let mut contents = String::new();
                            if file.read_to_string(&mut contents).is_ok() {
                                writeln!(output_file, "File Name: {}", file_name)?;
                                writeln!(output_file, "{}", contents)?;
                                writeln!(output_file, "-----------------\n\n")?;
                            } else {
                                println!("Can't read file: {}", file_name);
                                unreadable_files.push(path.to_string_lossy().to_string());
                            }
                        }
                        Err(_) => {
                            println!("Can't open file: {}", file_name);
                            unreadable_files.push(path.to_string_lossy().to_string());
                        }
                    }
                }
            }
        }
        Ok(())
    }

    visit_dirs(
        Path::new(folder_path),
        &mut output_file,
        &ignore_files,
        &mut unreadable_files,
    )?;

    // Print unreadable files to the terminal
    if !unreadable_files.is_empty() {
        println!("\nUnreadable files:");
        for file in unreadable_files {
            println!("{}", file);
        }
    }

    println!("Output written to {}", output_file_path);

    Ok(())
}
