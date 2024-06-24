function showSubmenu(submenuId) {
    // Hide all submenus
    var submenus = document.querySelectorAll(".dropdown-content > div > .submenu-w, .dropdown-content > div > .submenu-m");
    submenus.forEach(function(submenu) {
        submenu.style.display = "none";
    });

    // Show the submenu corresponding to the current menu item
    var submenu = document.querySelector("." + submenuId);
    if (submenu) {
        submenu.style.display = "block";
    }
}

function hideSubmenu(submenuId) {
    var submenu = document.querySelector("." + submenuId);
    if (submenu) {
        submenu.style.display = "none";
    }
}
function logout(){
	
      input1=document.getElementById("lg").value;
      
      document.getElementById("lg").value ="true";
		return true;
	
}
function validateForm() {
                            var quantity = document.getElementById('quantity').value;
                            if (!quantity) {
                                alert('Please select a quantity before adding to cart.');
                                return false; 
                            } else if (quantity < 1) {
                                document.getElementById('error').innerText = "Sold Out!!";
                                return false;
                            } else {
                                document.getElementById('hiddenQuantity').value = quantity;
                                return true; 
                            }
 }
                
//for admin home                
 function toggleProductIdField() {


    var operation = document.getElementById('operation').value;
    var productIdField = document.getElementById('productIdField');

    if (operation === "update" || operation === "delete") {
        productIdField.style.display = "block";
    } else {
        productIdField.style.display = "none";
    }
}

function validateCategory() {
    var category = document.getElementById('category').value;

    if (category == "") {
        document.getElementById('category_err').innerHTML = "Please select a category";
        return false;
    } else {
        document.getElementById('category_err').innerHTML = "";
        return true;
    }
}

function validateOperation() {
    var operation = document.getElementById('operation').value;

    if (operation == "") {
        document.getElementById('operation_err').innerHTML = "Please select an operation";
        return false;
    } else {
        document.getElementById('operation_err').innerHTML = "";
        return true;
    }
}

function validateProductId() {
    var operation = document.getElementById('operation').value;
    var productId = document.getElementById('productId').value;

    if ((operation === "update" || operation === "delete") && productId == "") {
        document.getElementById('productId_err').innerHTML = "Please enter the product ID";
        return false;
    } else {
        document.getElementById('productId_err').innerHTML = "";
        return true;
    }
}

function validateProductName() {
    var productName = document.getElementById('productName').value;

    if (document.getElementById('operation').value !== 'delete' && productName == "") {
        document.getElementById('productName_err').innerHTML = "Please enter the product name";
        return false;
    } else {
        document.getElementById('productName_err').innerHTML = "";
        return true;
    }
}

function validateProductDescription() {
    var productDescription = document.getElementById('productDescription').value;

    if (document.getElementById('operation').value !== 'delete' && productDescription == "") {
        document.getElementById('productDescription_err').innerHTML = "Please enter the product description";
        return false;
    } else {
        document.getElementById('productDescription_err').innerHTML = "";
        return true;
    }
}

function validateProductPrice() {
    var productPrice = document.getElementById('productPrice').value;

    if (document.getElementById('operation').value !== 'delete' && productPrice == "") {
        document.getElementById('productPrice_err').innerHTML = "Please enter the product price";
        return false;
    } else {
        document.getElementById('productPrice_err').innerHTML = "";
        return true;
    }
}

function validateProductPhoto() {
    var productPhoto = document.getElementById('productPhoto').value;

    if (document.getElementById('operation').value !== 'delete' && productPhoto == "") {
        document.getElementById('productPhoto_err').innerHTML = "Please enter the product photo URL";
        return false;
    } else {
        document.getElementById('productPhoto_err').innerHTML = "";
        return true;
    }
}

function validate() {
    if (validateCategory() && validateOperation() && validateProductId() && validateProductName() && validateProductDescription() && validateProductPrice() && validateProductPhoto()) {
        return true;
    }
    return false;
}
