use std::fs;
use std::io::Write;
use std::path::Path;

fn main() {
    let source_folder: &str = "./domain/src/entities";
    let destination_folder: &str = "./presentation/src/graphql/models";

    fs::create_dir_all(destination_folder).expect("Failed to create destination folder");

    let mut mod_contents = String::new();

    for entry in fs::read_dir(source_folder).expect("Failed to read folder") {
        let entry = entry.expect("Failed to get entry");
        let path = entry.path();

        if path.is_file() {
            let file_name = path
                .file_name()
                .expect("Failed to get file name")
                .to_str()
                .expect("Failed to convert file name");

            if file_name == "mod.rs"
                || file_name == "sea_orm_active_enums.rs"
                || file_name == "prelude.rs"
            {
                continue;
            }

            let destination_path = Path::new(destination_folder).join(file_name);

            if !destination_path.exists() {
                let mut file = fs::File::create(&destination_path).expect("Failed to create file");
                file.write_all(b"use async_graphql::{InputObject, SimpleObject};\n")
                    .expect("Failed to write to file");
                println!("Created {} with import", file_name);
            } else {
                println!("{} already exists, skipped", file_name);
            }

            let module_name = file_name.trim_end_matches(".rs");
            mod_contents.push_str(&format!("pub mod {};\n", module_name));
        }
    }

    let mod_path = Path::new(destination_folder).join("mod.rs");
    fs::write(mod_path, mod_contents).expect("Failed to write mod.rs");
    println!("Updated mod.rs with module declarations");
}
