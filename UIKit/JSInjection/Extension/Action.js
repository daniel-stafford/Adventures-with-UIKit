var Action = function() {};

Action.prototype = {

// tell iOS the JavaScript has finished preprocessing, and give this data dictionary to the extension.
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title });
},

finalize: function(parameters) {
    var customJavaScript = parameters["customJavaScript"];
    eval(customJavaScript);
}

};

var ExtensionPreprocessingJS = new Action
