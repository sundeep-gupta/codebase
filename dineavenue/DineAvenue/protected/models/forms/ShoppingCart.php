<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ShoppingCart
 *
 * @author skgupta
 */
class ShoppingCart {
  protected $cartItems;
  protected $total;
  protected $discount;
  protected $tax;
  public function __construct() {
    $this->cartItems = new CMap();
    
  }
  public function getCartItem($id) {
    return $this->cartItems->itemAt($id);
  }

  public function addCartItem($cartItem) {
    $this->cartItems->add($cartItem->getId(), $cartItem);
  }

  public function isCartItemPresent($id) {
    return $this->cartItems->contains($id);
  }

  public function toArray() {
    $keys = $this->cartItems->getKeys();

    $items = array();
    $this->total = 0;
    foreach($keys as $id) {
      $cartItem = $this->cartItems->itemAt($id);
      $this->total += $cartItem->getTotal();
      array_push($items, $cartItem->toArray());
    }
    $this->discount = 0;
    $this->tax = 0;
    return array('items' => $items, 'total' => $this->total, 'discount' => $this->discount, 'tax' => $this->tax);
  }

}

?>
