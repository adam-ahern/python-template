#!/bin/bash

# Determine which sed to use, gsed for Mac and sed for others
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED="gsed"
else
  SED="sed"
fi

# Function to replace text in files recursively in a directory
replace_text() {
  local search="$1"
  local replace="$2"
  local dir="$3"
  
  find "$dir" -type f -exec $SED -i "s/$search/$replace/g" {} +
}

# Rename Project Script
rename_project() {
  local old_project_name=$(basename "$(pwd)")
  local old_module_name="my_module"
  local parent_dir=$(dirname "$(pwd)")

  echo -n "Enter new project name: "
  read -r new_project_name

  # Usually the module name is the same as project name but it can be different
  echo -n "Enter new module name: "
  read -r new_module_name

  # Rename project folder
  cd "$parent_dir" || exit
  mv "$old_project_name" "$new_project_name"

  # Rename module
  if [ -d "$new_project_name/$old_module_name" ]; then
    mv "$new_project_name/$old_module_name" "$new_project_name/$new_module_name"
  fi

  # Replace text in pyproject.toml, Dockerfile, and all other files recursively
  replace_text "$old_project_name" "$new_project_name" "$new_project_name"
  replace_text "$old_module_name" "$new_module_name" "$new_project_name"

  # Reinitialize git
  rm -rf "$new_project_name/.git"
  cd "$new_project_name" || exit
  git init
}

# Usage
rename_project
echo "python-template is now deleted \n
You can now begin development in $new_project_name"