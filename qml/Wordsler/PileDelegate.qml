import Qt 4.7

Component {
    Item {
        //property alias isSelected: cardObject.isSelected
        //anchors.fill: parent
        id: main
        //parent: loc
        width: pile.cellWidth; height: pile.cellHeight
        //property bool selected: false

        Card {
            /*anchors.centerIn: parent;*/
            id: item;
            value: cardValue;
            isSelected: pileModel.get(index).selected
            text: cardText;
            parent: loc
            x: main.x; y: main.y

            //isSelected: selected
            //width: pile.cellWidth; height: pile.cellHeight

            Behavior on x { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
            Behavior on y { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }

            states: State {
                name: "active"; when: loc.currentId == gridId
                PropertyChanges { target: item; x: loc.mouseX - item.width/2; y: loc.mouseY - item.height/2; scale: 1.2 }
            }
            transitions: Transition { NumberAnimation { target: item; property: "scale"; duration: 200} }
        }

    }
}
