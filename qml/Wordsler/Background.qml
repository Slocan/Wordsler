import Qt 4.7

Image {
    function getBackgroundImage() {
        var backs = ["waterfall-tile.jpg",
                     "00-lucky-bamboo-background.jpg",
                     "00-lucky-clover-small.jpg",
                     "island-paradise-tile.jpg",
                     "waterfall-tile-blue.jpg",
                     "wood-repeating-fill-wavy.jpg"]
        //console.log(backs.length);
        //console.log(Math.random())
        var randValue = parseInt(Math.random() * backs.length);
        //console.log(randValue);
        return "images/" + backs[randValue];
    }

    anchors.fill: parent
    id: background
    source: getBackgroundImage();
    fillMode: Image.Tile
    opacity: 0.5
}
