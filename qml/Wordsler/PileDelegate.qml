import Qt 4.7

Item {
    //property alias isSelected: cardObject.isSelected
    //anchors.fill: parent
    id: main
    //parent: loc
    width: pile.cellWidth; height: pile.cellHeight
    Card {
        /*anchors.centerIn: parent;*/
        id: item;
        value: x;
        text: loc.mouseX;
        isSelected: selected
        width: pile.cellWidth; height: pile.cellHeight

        Behavior on x { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
        Behavior on y { enabled: item.state != "active"; NumberAnimation { duration: 400; easing.type: Easing.OutBack } }

        states: State {
            name: "active"; when: loc.currentId == gridId
            PropertyChanges { target: item; x: loc.mouseX - item.width/2 - main.x; y: loc.mouseY - main.y - item.height/2; scale: 1.2 }
        }
        transitions: Transition { NumberAnimation { target: item; property: "scale"; duration: 200} }
    }

}
