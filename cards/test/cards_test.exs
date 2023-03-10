defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck = Cards.create_deck()
    assert Enum.count(deck) == 20

    # this also works
    # deck_length = length(Cards.create_deck())
    # assert deck_length == 20
  end

  test "Card.shuffle actually shuffles the deck of card" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    assert length(deck) == length(shuffled_deck)
    refute deck == shuffled_deck
  end

  test "Cards.contains returns true for a card in the deck and false for a card not in the deck" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Four of Clubs") == true
    assert Cards.contains?(deck, "King of Clubs") == false
  end

  test "Cards.deal deals the corrrect hand size of cards" do
    hand_size = 4
    deck = Cards.create_deck()
    {deal, rest_of_deck} = Cards.deal(deck, hand_size)
    assert length(deal) == hand_size
    assert length(rest_of_deck) === length(deck) - hand_size
  end
end
