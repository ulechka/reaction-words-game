#!/usr/bin/env bash

WORD=$1

curl "http://adictru.nsu.ru/include/dict_queries.php?test=1&sex=E&spec=&city=&base=0&chr=${WORD}&reg=0&sort=0" -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.9,ru;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36' -H 'Accept: */*' -H 'Referer: http://adictru.nsu.ru/dictright' -H "Cookie: _ga=GA1.2.1162615606.1528893470; _ym_uid=1528893499710779255; pref_lang=ru; __utma=66658430.1162615606.1528893470.1529853553.1529853553.1; __utmc=66658430; __utmz=66658430.1529853553.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); back_1_s_criteria=E%3A%3A%3A%3A%3A%3A%3A%3A%D0%90%3A0%3A0; test=1; stim_1_s_criteria=%3A%3A%3A%3A%3A%3A%3A%3Aa%3A0%3A0; dict=right; __utmt=1; __utmb=66658430.7.10.1529853553; right_1_s_criteria=${WORD}" -H 'Connection: keep-alive' --compressed | grep -E -o "(<span class='rsp'>[^<]*<\\/span>)|(\\\\\\d+\\\\)" | sed "s/<span class='rsp'>//g" | sed "s/<\/span>//g"

# 