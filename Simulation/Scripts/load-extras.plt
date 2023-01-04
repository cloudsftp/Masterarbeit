file_exists(file) = int(system("[ -f '".file."' ] && echo '1' || echo '0'"))
if (file_exists('extras.plt')) load 'extras.plt'
