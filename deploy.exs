defmodule PhoenixSlackPosting.DeployCallbacks do
  import Gatling.Bash

  def before_mix_digest(env) do
    bash("mkdir", ~w[-p priv/static], cd: env.build_dir)
		bash("npm", ~w[install], cd: "#{env.build_dir}/assets")
  end
end
