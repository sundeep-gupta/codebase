function moveSelectedItemUp(list)
{
  if (list.selectedIndex < 1)
    { return; }
      
  _switchItems(list, list.selectedIndex, list.selectedIndex - 1);
  list.selectedIndex = list.selectedIndex - 1;
}
  
function moveSelectedItemDown(list)
{
  if ( (list.selectedIndex == -1) || (list.selectedIndex == list.length - 1) )
    { return; }
  
  _switchItems(list, list.selectedIndex, list.selectedIndex + 1);
  list.selectedIndex = list.selectedIndex + 1;
}

function _switchItems(list, a, b)
{
  var optionA = { text: list.options[a].text, value: list.options[a].value };
  var optionB = { text: list.options[b].text, value: list.options[b].value };
    
  list.options[a].text = optionB.text;
  list.options[a].value = optionB.value;

  list.options[b].text = optionA.text;
  list.options[b].value = optionA.value;
    
}

function selectEverything()
{
  var theForm = document.theForm;
  
  for (var i=0; i < theForm.selectedSteps.length; i++)
  {
    theForm.VAL.value=theForm.VAL.value + theForm.selectedSteps.options[i].value + ":";
  }
}    

function moveSelectedItem(fromList, toList)
{
  if (fromList.selectedIndex == -1)
    { return; }
  
  var fromSelectedIndex, toSelectedIndex, itemValue, itemText, itemIndex;
  while (fromList.selectedIndex != -1)
  {
    fromSelectedIndex = fromList.selectedIndex;
    toSelectedIndex = toList.selectedIndex;
      
    itemValue = fromList.options[fromSelectedIndex].value;
    itemText = fromList.options[fromSelectedIndex].text;
    itemIndex = toList.length;
    toList.options[itemIndex] = new Option(itemText, itemValue);
      
    // if there is a selection in toList, move new item after selection
    fromList.options[fromSelectedIndex] = null;
    if (toSelectedIndex != -1)
    {
      while (toSelectedIndex < itemIndex - 1)
      {
        _switchItems(toList, itemIndex, --itemIndex);
      }
    toList.selectedIndex = itemIndex;
    }
  }
  toList.focus();
  return;
}
  

function addStepToGroup()
  {
  var elAvailable = document.theForm.availableSteps;
  var elSelected = document.theForm.selectedSteps;
  
  while (elAvailable.selectedIndex != -1)
    {
//    if (elSelected.length < maxCCMPerGroup)
//      {
      moveSelectedItem(elAvailable, elSelected);
//      }
//    else
//      {
//      var msg = "<%= jsMsgMaxCCMPerGroup %>".replace(/#/, maxCCMPerGroup).toString();
//      showValidationError(elSelected, msg, 0);
//     break;
//      }
    }
  return;
  }
  
function removeStepFromGroup()
  {
  var elSelected = document.theForm.selectedSteps;
  while (elSelected.selectedIndex != -1)
    {
    moveSelectedItem(elSelected, document.theForm.availableSteps);
    }
  return;
  }
