// ==UserScript==
// @name         Team Infra Pipeline Summary
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Give a summary on the team's pipelines.
// @author       @hczhang Honngchang Zhang
// @match        https://pipelines.amazon.com/teams/Economic%20Selling
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// @downloadURL  https://drive-render.corp.amazon.com/view/wael@/Experiments/PhoneTool%20Enhance/PhoneTool Enhance.user.js

// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    var pipeline_num = document.getElementsByClassName("pipelines")[0].rows.length;

    var element = "<div><div>Total Pipeline Count:</div><div>" + dataAccessor().pipeline_num +"</div></div>";
    var theKid = document.createElement("div");
    theKid.innerHTML = element;
    document.getElementById("content").prepend(theKid);

    function dataAccessor() {

        var pipeline_num = document.getElementsByClassName("pipelines")[0].rows.length;

        // other attributes


        var data = {
            'pipeline_num': pipeline_num
        };

        return data;

    }
})();


