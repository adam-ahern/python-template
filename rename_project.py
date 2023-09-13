import os
import shutil
from pathlib import Path

def replace_text_in_file(file_path: Path, old_text: str, new_text: str) -> None:
    with open(file_path, "r") as f:
        content = f.read()
    
    content = content.replace(old_text, new_text)
    
    with open(file_path, "w") as f:
        f.write(content)

def rename_project(old_project_name: str, old_module_name: str, new_project_name: str, new_module_name: str) -> None:
    # Rename project folder
    shutil.move(old_project_name, new_project_name)

    # Rename module
    old_module_path = Path(new_project_name) / old_module_name
    new_module_path = Path(new_project_name) / new_module_name
    old_module_path.rename(new_module_path)

    # Update references in pyproject.toml and code files
    pyproject_file = Path(new_project_name) / "pyproject.toml"
    replace_text_in_file(pyproject_file, old_module_name, new_module_name)

    for py_file in Path(new_project_name).rglob("*.py"):
        replace_text_in_file(py_file, old_module_name, new_module_name)
    
    # Re-initialize Git
    shutil.rmtree(Path(new_project_name) / ".git")
    os.system(f"cd {new_project_name} && git init")

if __name__ == "__main__":
    new_project_name = input("New project name: ")
    new_module_name = input("New module name: ")
    rename_project("python-template", "my_module", new_project_name, new_module_name)
