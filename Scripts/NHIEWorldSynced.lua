UnityEngine = require("UnityEngine")

-- Reference to the animator component (Make sure to bind "animobj" in Unity)
local animator = BoundObjects.animobj:GetComponent("UnityEngine.Animator")

-- Reference to the UI Text component (Bind "NHIEText" in Unity)
local nhieTextObject = BoundObjects.NHIEText

-- Table of NHIE questions
local nhieQuestions = {
    "question1",
    "question2",
    "question3"
}

function Update()
    -- Get the integer value from the animator's parameter
    local currentIndex = animator:GetInteger("NHIECurrentIndex")

    -- Safety check to make sure the index is within valid range
    if currentIndex >= 1 and currentIndex <= #nhieQuestions then 
        local textComponent = nhieTextObject:GetComponent("UnityEngine.UI.Text")
        textComponent.text = nhieQuestions[currentIndex]
    else
        print("Error: Invalid index value from animator:", currentIndex) 
    end
end

-- Initial function call to set the text on start
function Start()
    if not nhieTextObject then
        print("Error: NHIEText not bound in ChilloutVR inspector.")
    end
    if not animator then
        print("Error: animobj Animator not found.")
    end
end