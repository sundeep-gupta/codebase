
window.onload = function(){
     $('#page').text("loading...")
     $('#menu').load('jspf/Menu.jsp',{})
     $('#logo').load('jspf/Logo.jsp',{})
     $('#page').load("jspf/index.jsp",{})
     $('#footer').load('jspf/Footer.jsp',{})
};

function showCuisineMenu() {
    var html = '<ul>'+
                '<li><a id="c_new"    href="javascript:addCuisineForm()">New</a></li>' +
                '<li><a id="c_delete" href="javascript:deleteCuisine()">Delete</a></li>' +
                '<li><a id="c_edit"   href="javascript:editCuisineForm()">Edit</a></li>' +
                '<li><a id="c_show"   href="javascript:showCuisines()">Refresh</a></li>' +
                '</ul>'
     $('#submenu').html(html)
     showCuisines()
 //    $('#center_body').load('jspf/ShowCuisines.jsp')
}

function showCuisines() {
    $('#center_body').load('ShowCuisines',{})
}

function addCuisine() {
    var cName = $('#c_name').val()
    var cDesc = $('#c_desc').val()
    var cPrice = $('#c_price').val()
    // TODO : Client side validations.
    $('#center_body').load('AddCuisine', {name:cName, desc:cDesc, price:cPrice})
}

function addCuisineForm() {
    var formHtml = '<h2>New Cuisine</h2>' +
'<form id="add_cuisine" action="">' +
    '<label for="c_name">Name : </label><input type="text" id="c_name" name="c_name" value=""/><br/>' +
    '<label for="c_desc">Desc : </label><input type="text" id="c_desc" name="c_desc" value=""/><br/>' +
    '<label for="c_price">Price : </label><input type="text" id="c_price" name="c_price" value=""/><br/>' +
    '<input type="button" id="c_submit" name="create" value="Create" onclick="javascript:addCuisine()"/><br/>' +
'</form>'
    // TODO : Change the sub-menu if required (when in new, we do not require 'Edit', 'Delete'
    $('#center_body').html(formHtml)
}

function editCuisineForm() {
    var cidVal = $('input[name^=c_id]:checked').val()
    $('#center_body').load("jspf/EditCuisineForm.jsp",{id : cidVal});
}

function editCuisine() {
    var cId = $('#c_id').val()
    var cName = $('#c_name').val()
    var cDesc = $('#c_desc').val()
    var cPrice = $('#c_price').val()
    // TODO : Client side validations.
    alert(cId + cName)
    $('#center_body').load('EditCuisine', {id:cId, name:cName, desc:cDesc, price:cPrice})
}

function deleteCuisine() {
    var c_id = $('input[name^=c_id]:checked').val()
    $('#center_body').load("DeleteCuisine",{id : c_id});
}

/**
 * Loads the list of food items from the server.
 * Also gets the list of sub-menu from server.
 */
function showFoodItem() {
    var vHtml = '<a href="javascript:editFoodItemForm()" id="fi_edit">Edit</a>' +
                '<a href="javascript:addFoodItemForm()"  id="fi_new">New</a>' +
                '<a href="javascript:deleteFoodItem()"   id="fi_delete">Delete</a>' +
                '<a href="javascript:showFoodItem()"     id="fi_refresh">Refresh</a>'

    $('#submenu').html(vHtml)
    $('#center_body').load('ShowFoodItems',{})
}

function addFoodItemForm() {
    var formHtml = '<h2>New Food Item</h2>' +
'<form id="add_cuisine" action="">' +
    '<label for="f_name">Name : </label><input type="text" id="f_name" name="f_name" value=""/><br/>' +
    '<label for="f_desc">Desc : </label><input type="text" id="f_desc" name="f_desc" value=""/><br/>' +
    '<label for="f_price">Price : </label><input type="text" id="f_price" name="f_price" value=""/><br/>' +
    '<input type="button" id="c_submit" name="create" value="Create" onclick="javascript:addFoodItem()"/><br/>' +
'</form>'
    // TODO : Change the sub-menu if required (when in new, we do not require 'Edit', 'Delete'
    $('#center_body').html(formHtml)
}

function addFoodItem() {
    var fiName = $('#f_name').val()
    var fiDesc = $('#f_desc').val()
    var fiPrice = $('#f_price').val()
    // TODO : Client side validations.
    $('#center_body').load('AddFoodItem', {name:fiName, desc:fiDesc, price:fiPrice})
}

/*
 * Function called to get the edit form for selected food item.
 * 1. Get the currently selected food item.
 * 2. Send a AJAX GET request to get the form with given food item.
 */
function editFoodItemForm() {
    var f_id = $('input[name^=fi_id]:checked').val()
    alert(f_id + "called with id")
    $('#center_body').load("jspf/EditFoodItemForm.jsp",{id : f_id});
}

/*
 * JavaScript method to finally update the FoodItem.
 */
function editFoodItem() {
    var fiId = $('#f_id').val()
    var fiName = $('#f_name').val()
    var fiDesc = $('#f_desc').val()
    var fiPrice = $('#f_price').val()
    // TODO : Client side validations.
    $('#center_body').load('EditFoodItem', {id:fiId, name:fiName, desc:fiDesc, price:fiPrice})
}

/*
 * Get the ID to be deleted and DELETE it!!!
 */
function deleteFoodItem() {
    var f_id = $('input[name^=fi_id]:checked').val()
    $('#center_body').load("DeleteFoodItem",{id : f_id});
}

/***************************************************************************
 * All Functions Related to Subscriptions
 ***************************************************************************/

function showSubscriptions() {

    var vHtml = '<a href="javascript:editSubscriptionForm()" id="s_edit">Edit</a>' +
                '<a href="javascript:addSubscriptionForm()"  id="s_new">New</a>' +
                '<a href="javascript:deleteSubscription()"   id="s_delete">Delete</a>' +
                '<a href="javascript:showSubscriptions()"     id="s_refresh">Refresh</a>'

    $('#submenu').html(vHtml)
    $('#center_body').load('ShowSubscriptions',{})
}

function addSubscriptionForm() {
    $('#center_body').load("AddSubscriptionForm");
}

function addSubscription() {
    s_name = $('input[name^=s_name]').val()
    $('#center_body').load("AddSubscription", {})
}

function editSubscriptionForm() {
    var s_id = $('input[name^=s_id]:checked').val()
    $('#center_body').load("EditSubscriptionForm",{id : s_id});
}

function editSubscription() {
    var s_id = $('input[name=^s_id]').val()
    var s_name = $('input[name=^s_name]').val()
    var s_desc = $('input[nam=^s_desc]').val()

    $('#center_body').load("EditSubscription", {id: s_id})
}

function deleteSubscription() {
    var s_id = $('input[name^=s_id').val()
    $('#center_body').load("DeleteSubscription", {id: s_id})
}

/***************************************************************************
 * All Functions Related to USER MANGGEMENT
 ***************************************************************************/

function showUsers() {

}

function addUserForm() {

}

function addUser() {

}

function editUserForm() {

}

function editUser() {

}

function deleteUser() {

}

function adminLogin() {
    var emailVal = $('input[name^=email]').val();
    var passwordVal = $('input[name^=password]').val();
    $('#page').load('../Login', {email : emailVal, password : passwordVal});
}

function adminLogout() {
    $('#page').load('../Logout')
}


