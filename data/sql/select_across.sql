SELECT sentence.id, sentence.words
    FROM tag, sentence_tag, sentence
    WHERE
    tag.id = sentence_tag.tag_id AND
    sentence_tag.sentence_id = sentence.id;
    --AND
    --tag.word != "this";
