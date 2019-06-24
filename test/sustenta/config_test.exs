defmodule Sustenta.ConfigTest do
  use Sustenta.DataCase

  alias Sustenta.Config

  describe "config_ambits" do
    alias Sustenta.Config.Ambit

    @valid_attrs %{name: "some name", number: 42}
    @update_attrs %{name: "some updated name", number: 43}
    @invalid_attrs %{name: nil, number: nil}

    def ambit_fixture(attrs \\ %{}) do
      {:ok, ambit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Config.create_ambit()

      ambit
    end

    test "list_config_ambits/0 returns all config_ambits" do
      ambit = ambit_fixture()
      assert Config.list_config_ambits() == [ambit]
    end

    test "get_ambit!/1 returns the ambit with given id" do
      ambit = ambit_fixture()
      assert Config.get_ambit!(ambit.id) == ambit
    end

    test "create_ambit/1 with valid data creates a ambit" do
      assert {:ok, %Ambit{} = ambit} = Config.create_ambit(@valid_attrs)
      assert ambit.name == "some name"
      assert ambit.number == 42
    end

    test "create_ambit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Config.create_ambit(@invalid_attrs)
    end

    test "update_ambit/2 with valid data updates the ambit" do
      ambit = ambit_fixture()
      assert {:ok, %Ambit{} = ambit} = Config.update_ambit(ambit, @update_attrs)
      assert ambit.name == "some updated name"
      assert ambit.number == 43
    end

    test "update_ambit/2 with invalid data returns error changeset" do
      ambit = ambit_fixture()
      assert {:error, %Ecto.Changeset{}} = Config.update_ambit(ambit, @invalid_attrs)
      assert ambit == Config.get_ambit!(ambit.id)
    end

    test "delete_ambit/1 deletes the ambit" do
      ambit = ambit_fixture()
      assert {:ok, %Ambit{}} = Config.delete_ambit(ambit)
      assert_raise Ecto.NoResultsError, fn -> Config.get_ambit!(ambit.id) end
    end

    test "change_ambit/1 returns a ambit changeset" do
      ambit = ambit_fixture()
      assert %Ecto.Changeset{} = Config.change_ambit(ambit)
    end
  end

  describe "config_standards" do
    alias Sustenta.Config.Standard

    @valid_attrs %{name: "some name", number: 42}
    @update_attrs %{name: "some updated name", number: 43}
    @invalid_attrs %{name: nil, number: nil}

    def standard_fixture(attrs \\ %{}) do
      {:ok, standard} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Config.create_standard()

      standard
    end

    test "list_config_standards/0 returns all config_standards" do
      standard = standard_fixture()
      assert Config.list_config_standards() == [standard]
    end

    test "get_standard!/1 returns the standard with given id" do
      standard = standard_fixture()
      assert Config.get_standard!(standard.id) == standard
    end

    test "create_standard/1 with valid data creates a standard" do
      assert {:ok, %Standard{} = standard} = Config.create_standard(@valid_attrs)
      assert standard.name == "some name"
      assert standard.number == 42
    end

    test "create_standard/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Config.create_standard(@invalid_attrs)
    end

    test "update_standard/2 with valid data updates the standard" do
      standard = standard_fixture()
      assert {:ok, %Standard{} = standard} = Config.update_standard(standard, @update_attrs)
      assert standard.name == "some updated name"
      assert standard.number == 43
    end

    test "update_standard/2 with invalid data returns error changeset" do
      standard = standard_fixture()
      assert {:error, %Ecto.Changeset{}} = Config.update_standard(standard, @invalid_attrs)
      assert standard == Config.get_standard!(standard.id)
    end

    test "delete_standard/1 deletes the standard" do
      standard = standard_fixture()
      assert {:ok, %Standard{}} = Config.delete_standard(standard)
      assert_raise Ecto.NoResultsError, fn -> Config.get_standard!(standard.id) end
    end

    test "change_standard/1 returns a standard changeset" do
      standard = standard_fixture()
      assert %Ecto.Changeset{} = Config.change_standard(standard)
    end
  end
end
