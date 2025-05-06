import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Renamer

Window {
    width: 800
    height: 600
    visible: true
    title: "Rename Exported Mac Photos"
    color: "#f0f0f0"

    Renamer { id: renamer }

    property var dryRunResults: []
    property real leftScrollY: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            TextField {
                id: pathField
                Layout.fillWidth: true
                placeholderText: "Paste a full path; eg. /Users/you/Pictures/ContainerFolder"
                placeholderTextColor: "grey"
                text: "/Users"
            }

            Button {
                text: "Set path"
                onClicked: renamer.path = pathField.text
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Label {
                    text: "Pre-conversion"
                    font.bold: true
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#444"
                    radius: 4

                    ListView {
                        id: leftList
                        anchors.fill: parent
                        model: renamer.contents
                        interactive: true
                        clip: true
                        onContentYChanged: leftScrollY = contentY

                        delegate: Rectangle {
                            width: leftList.width
                            height: childrenRect.height
                            color: "#eee"
                            border.color: "#ccc"

                            Text {
                                padding: 4
                                elide: Qt.ElideRight
                                text: modelData
                                color: "black"
                                font.pixelSize: 12
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: pathField.text += '/' + modelData
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Label {
                    text: "Post-conversion"
                    font.bold: true
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#444"
                    radius: 4

                    ListView {
                        id: rightList
                        anchors.fill: parent
                        model: dryRunResults
                        interactive: false
                        clip: true
                        contentY: leftScrollY

                        delegate: Rectangle {
                            width: rightList.width
                            height: childrenRect.height
                            color: "#eee"
                            border.color: "#ccc"
                            Text {
                                padding: 4
                                elide: Qt.ElideRight
                                text: modelData
                                color: "black"
                                font.pixelSize: 12
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Button {
                Layout.fillWidth: true
                text: "Test conversion"
                onClicked: {
                    let hash = renamer.conversionDryRun()
                    let keys = Object.keys(hash).sort()
                    dryRunResults = keys.map(k => hash[k])
                }
            }

            Button {
                Layout.fillWidth: true
                text: "Do conversion"
                onClicked: {
                    renamer.doConversion()
                    dryRunResults = []
                }
            }
        }
    }
}
