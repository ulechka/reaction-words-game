#!/usr/bin/env bash

# get random word from stimul.txt
stimul=$(cat stimul.txt | gshuf -n 1)

# read reactions from corresponding file
# remove counts
# replase whitespace with underscore
reactions=$(cat reactions/${stimul}.txt | sed "s/ /_/g" | grep -v '\\')
# 
# make the list of reactions to print
reactions_to_show="\nАссоциации:"
# list of user inputs
guesses=''

# print the rules
cat << EOF
    Мы загадали слово. Сходили на улицу и попросили
    разных людей рассказать свои ассоциации на это слово.
    Полученные ассоциации отсортировали в порядке
    частоты их появления в ответах. И теперь предлагаем
    вам угадать слово по этим ассоциациям.
    
    Мы будем показывать вам по одной ассоциации за раз,
    а вы называйте вариант ответа.
    
    Удачи!
    
    P.S. Количество ассоциаций к каждому слову ограничено,
    но вы можете закончить игру в любой момент, введя
    в качестве своего ответа слово 'сдаюсь'.
EOF

# TODO: echo "$help"

# iterate reactions
for reaction in $reactions; do
    # add reaction to the list to print
    reactions_to_show="${reactions_to_show}\n    ${reaction}"

    # print reactions
    printf "${reactions_to_show}"
    echo ''
    if [ ! -z "${guesses}" ]; then
        echo 'Вы уже попробовали:'
        printf "${guesses}"
        echo ''
    fi

    guess=''
    while [ -z "${guess}" ]; do
        # prompt user to input
        echo -n "&_^>"

        # get a guess
        read -e guess
        
        if [ "${guess}" = "сдаюсь" ]; then
            echo "Мне жаль! Правильный ответ: ${stimul}"
            exit 0
        fi

        # check if user repeats
        count=$(echo "${guesses}" | grep -o "    ${guess}\\\\n" | wc -l)
        if [ ${count} -gt 0 ]; then
            echo 'Вы уже такой вариант пробовали'
            guess=''
        fi
    done
    
    guesses="${guesses}    ${guess}\n"
    
    # check if the guess right
    if [ "${guess}" = "${stimul}" ]; then
        # Congrats
        echo "Ты молодец!"
        exit 0
    fi
    # guess is wrong, go to next iteration
done

# list of reactions ends. Show the answer:
echo "Мне жаль! Правильный ответ: ${stimul}"


