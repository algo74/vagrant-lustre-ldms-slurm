find . -name .git -type d -execdir sh -c 'echo +  +  +  + ;pwd ;git status ;git submodule foreach  --recursive "git status"' \;
