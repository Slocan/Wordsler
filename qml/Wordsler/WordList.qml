import Qt 4.7

XmlListModel {
    id: xmlModel
    source: "wordlist2.xml"
    //query: "/words"

    function checkWord(word) {
        // Returns the number of entries in the XML data for this word (0 means word not found, 1 means word found)
        query = "/words/"+ word;
        console.log(status);
        if (status == XmlListModel.Ready) {
            return count;
        } else {
            return -1;
        }
    }
}
