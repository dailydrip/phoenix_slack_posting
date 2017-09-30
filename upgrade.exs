defmodule PhoenixSlackPosting.UpgradeCallbacks do
  import Gatling.Bash

  def before_mix_digest(env) do
    bash("npm", ~w[install], cd: env.build_dir)
  end

  def before_upgrade_service(env) do
    bash("mix", ~w[ecto.migrate], cd: env.build_dir)
  end
end
