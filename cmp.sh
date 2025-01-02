for file in ./*.out; do
    filename=$(basename "$file")
    file2="true_out/$filename"

    if [ -f "$file2" ]; then
        echo "Comparing $filename..."
        if ! diff -q "$file" "$file2" > /dev/null; then
            echo "Different: $filename"
        fi
    else
        echo "File $filename exists in dir1 but not in dir2."
    fi
done
