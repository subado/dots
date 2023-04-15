#!/usr/bin/env bash

copy()
{
	local prefix="$1"; shift;
	local files="$1"; shift;

	cd $prefix
	echo "Copy files $files to $prefix"
	sudo gphoto2 --get-file $files

	if [ $? -ne 0 ]; then
		echo "Command \"gphoto2 --get-file $files\" didn't executed properly"
		exit 1
	fi
  read -r -d '' -a file_name < <(find . -maxdepth 1 -type f -printf "%p\n" | sed 's/\.\///')
	if [[ "$file_name" != "" ]]; then
		case "$1" in
			-d|--date) customDate "$@";;
		esac

    for i in ${file_name[@]}
    do
      datetime "$i"
    done
	else
		echo "Something went wrong"
		exit 1
	fi
}

customDate()
{
  path="$(date -d "$2" +'%Y/%m/')"; shift
  file=$(date -d "$1" +'%d')
}

datetime()
{
  IFS=$':' read -r -d '' -a birth_date < <(file "$1" | sed 's/ /\n/g' | grep datetime | sed 's/datetime=//g')

  path=""
  file=${birth_date[2]::-1}
  for i in ${birth_date[@]::${#birth_date[@]}-1}
  do
    path="$path/$i"
  done

  path=${path:1}

  mkdir -p -v "$path"

  local new_file_name="${file}.JPG"

  mv "$1" "$new_file_name"
  echo "Rename \"$1\" to \"$new_file_name\""
  mv "$new_file_name" "$path"
  echo "Move \"$new_file_name\" to \"$path\""

}

case "$1" in
	*) copy "$@" ;;
esac
