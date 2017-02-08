dsearch() {


    data=$(curl -s https://raw.githubusercontent.com/derimagia/drupalhound/master/data/project_module-7.x-released.txt)
    for arg in $*; do
        data=$(echo $data | grep "$arg")
    done;
    ink -lc g 'D7:'
    print -l $data

    hr ' ' '-' ' '

    ink -lc g 'D8:'
    data=$(curl -s https://raw.githubusercontent.com/derimagia/drupalhound/master/data/project_module-8.x-released.txt)
    for arg in $*; do
        data=$(echo $data | grep "$arg")
    done;
    print -l $data
}
