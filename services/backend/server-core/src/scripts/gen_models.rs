use std::fs;
use std::path::Path;

fn main() {
    let source_folder = "source_folder";
    let destination_folder = "destination_folder";

    fs::create_dir_all(destination_folder).expect("コピー先フォルダの作成に失敗しました");

    for entry in fs::read_dir(source_folder).expect("フォルダの読み込みに失敗しました")
    {
        let entry = entry.expect("エントリの取得に失敗しました");
        let path = entry.path();

        if path.is_file() {
            let file_name = path
                .file_name()
                .expect("ファイル名の取得に失敗しました")
                .to_str()
                .expect("ファイル名の変換に失敗しました");

            if file_name == "mod.rs" {
                continue;
            }

            let destination_path = Path::new(destination_folder).join(file_name);

            if !destination_path.exists() {
                fs::copy(&path, &destination_path).expect("ファイルのコピーに失敗しました");
                println!("{} をコピーしました", file_name);
            } else {
                println!("{} は既に存在するためスキップしました", file_name);
            }
        }
    }
}
