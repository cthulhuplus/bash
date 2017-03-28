echo "$(head -$((${RANDOM} % `wc -l < adjectives.txt` + 1)) adjectives.txt |tail -1)$(head -$((${RANDOM} % `wc -l < roman.txt` + 1)) roman.txt |tail -1)"
