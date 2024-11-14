defmodule Examples.ECairo.EResourceLogic do
  use Memoize

  alias Anoma.CairoResource.ProofRecord
  alias Examples.ECairo.EProofRecord
  alias Anoma.CairoResource.LogicOutput
  alias Examples.ECairo.EResource

  use TestHelper.TestMacro

  @spec a_input_resource_logic() :: ProofRecord.t()
  defmemo a_input_resource_logic() do
    res =
      EProofRecord.a_resource_logic(
        "params/trivial_input_resource_logic_witness.json"
      )

    output = res.public_inputs |> LogicOutput.from_public_input()

    plaintext = LogicOutput.decrypt(output.cipher, <<1::256>>)

    a_resource = EResource.a_fixed_resource()

    expected_text = [
      a_resource.logic,
      a_resource.label,
      a_resource.quantity,
      a_resource.data,
      <<0::256>>,
      a_resource.nonce,
      a_resource.npk,
      a_resource.rseed,
      <<0::256>>,
      <<0::256>>
    ]

    assert expected_text == plaintext

    res
  end

  @spec a_output_resource_logic() :: ProofRecord.t()
  defmemo a_output_resource_logic() do
    EProofRecord.a_resource_logic(
      "params/trivial_output_resource_logic_witness.json"
    )
  end
end