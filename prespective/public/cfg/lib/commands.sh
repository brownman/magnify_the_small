
cat <<EOF > test.yaml
name: "MyName !!"
subvalue:
    how-much: 1.1
    how-many: 2
    things:
        - first
        - second
        - third
    maintainer: "Valentin Lab"
    description: |
        Multiline description:
        Line 1
        Line 2
EOF
