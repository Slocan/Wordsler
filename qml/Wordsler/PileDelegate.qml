import Qt 4.7

Item {
    //property alias isSelected: cardObject.isSelected
    //anchors.fill: parent
    Card { /*anchors.centerIn: parent;*/ id: cardObject; value: cardValue; text: cardText; isSelected: pileModel.get(index).selected }
    MouseArea {
        anchors.fill: cardObject
        onClicked: {
            if (!pileModel.get(index).selected) {
                choicesModel.append( { card: cardText } );
            } else {
                choicesModel.remove( choicesModel.getIndex(cardText));
            }
            pileModel.get(index).selected = !pileModel.get(index).selected
            //pileModel.setProperty(index,selected, !pileModel.get(index).selected)
            //pileModel.sync();
            //isSelected= pileModel.get(index).selected;
            //console.log(cardObject.isSelected)
            //selected = !selected;
        }
    }
}
