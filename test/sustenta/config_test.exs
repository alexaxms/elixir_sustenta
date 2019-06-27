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

  describe "config_survey_templates" do
    alias Sustenta.Config.SurveyTemplate

    @valid_attrs %{active: true, name: "some name"}
    @update_attrs %{active: false, name: "some updated name"}
    @invalid_attrs %{active: nil, name: nil}

    def survey_template_fixture(attrs \\ %{}) do
      {:ok, survey_template} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Config.create_survey_template()

      survey_template
    end

    test "list_config_survey_templates/0 returns all config_survey_templates" do
      survey_template = survey_template_fixture()
      assert Config.list_config_survey_templates() == [survey_template]
    end

    test "get_survey_template!/1 returns the survey_template with given id" do
      survey_template = survey_template_fixture()
      assert Config.get_survey_template!(survey_template.id) == survey_template
    end

    test "create_survey_template/1 with valid data creates a survey_template" do
      assert {:ok, %SurveyTemplate{} = survey_template} = Config.create_survey_template(@valid_attrs)
      assert survey_template.active == true
      assert survey_template.name == "some name"
    end

    test "create_survey_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Config.create_survey_template(@invalid_attrs)
    end

    test "update_survey_template/2 with valid data updates the survey_template" do
      survey_template = survey_template_fixture()
      assert {:ok, %SurveyTemplate{} = survey_template} = Config.update_survey_template(survey_template, @update_attrs)
      assert survey_template.active == false
      assert survey_template.name == "some updated name"
    end

    test "update_survey_template/2 with invalid data returns error changeset" do
      survey_template = survey_template_fixture()
      assert {:error, %Ecto.Changeset{}} = Config.update_survey_template(survey_template, @invalid_attrs)
      assert survey_template == Config.get_survey_template!(survey_template.id)
    end

    test "delete_survey_template/1 deletes the survey_template" do
      survey_template = survey_template_fixture()
      assert {:ok, %SurveyTemplate{}} = Config.delete_survey_template(survey_template)
      assert_raise Ecto.NoResultsError, fn -> Config.get_survey_template!(survey_template.id) end
    end

    test "change_survey_template/1 returns a survey_template changeset" do
      survey_template = survey_template_fixture()
      assert %Ecto.Changeset{} = Config.change_survey_template(survey_template)
    end
  end
end
