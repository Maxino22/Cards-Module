defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a dec of cards
  """
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns card when shuffled

  ## Example
      iex> deck = Cards.create_deck
      iex> deck != Cards.shuffle(deck)

  """
  def shuffle(deck) do
    deck
    |> Enum.shuffle()
  end

  @doc """
    Determines weather a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into hand and the reminder of the deck. The
    `hand_size` argument indicates how many cards should be in the hand.

    ## Examples
        iex> deck = Cards.create_deck()
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Save method writes to a file specified in the file system `filename`

  ## Example
      iex> deck = Cards.create_deck
      iex> Cards.save(deck, "file.txt")
      :ok
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Reads from file system to addd deck from a file..
    Pass the `filename`
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _msg} -> "something went wrong file or not there"
    end
  end

  @doc """
     Create Deck shuffles and deals card all in one step.
     To the specified hand size

  """

  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end
