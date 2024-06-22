import QtQuick

QtObject {
    id: control
    property var properties: ({})
    property var property_names: []

    function getPropertiesReady(){
        properties = {}
        for (let i = 0; i < property_names.length; i++){
            if(typeof control[property_names[i]] !== 'undefined')
            {
                properties[property_names[i]] = control[property_names[i]]
            }
        }
    }
}
