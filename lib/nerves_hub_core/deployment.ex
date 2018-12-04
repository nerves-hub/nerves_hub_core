defmodule NervesHubCore.Deployment do
  @moduledoc """
  Manage NervesHub deployments

  Path: /orgs/:org_name/products/:product_name/deployments
  """
  alias NervesHubCore.{Auth, Product}

  @path "deployments"

  @doc """
  List all deployments for a product.

  Verb: GET
  Path: /orgs/:org_name/products/:product_name/deployments
  """
  @spec list(atom() | binary(), atom() | binary(), NervesHubCore.Auth.t()) ::
          {:error, any()} | {:ok, any()}
  def list(org_name, product_name, %Auth{} = auth) do
    NervesHubCore.request(:get, path(org_name, product_name), "", auth)
  end

  @doc """
  Create a new deployment.

  Verb: POST
  Path: /orgs/:org_name/products/:product_name/deployments
  """
  @spec create(
          atom() | binary(),
          atom() | binary(),
          atom() | binary(),
          atom() | binary(),
          atom() | binary(),
          [atom() | binary()],
          NervesHubCore.Auth.t()
        ) :: {:error, any()} | {:ok, any()}
  def create(org_name, product_name, name, firmware, version, tags, %Auth{} = auth) do
    params = %{
      name: name,
      firmware: firmware,
      conditions: %{version: version, tags: tags},
      is_active: false
    }

    NervesHubCore.request(:post, path(org_name, product_name), params, auth)
  end

  @doc """
  Update an existing deployment.

  Verb: PUT
  Path: /orgs/:org_name/products/:product_name/deployments/:depolyment_name
  """
  @spec update(atom() | binary(), atom() | binary(), binary(), map(), NervesHubCore.Auth.t()) ::
          {:error, any()} | {:ok, any()}
  def update(org_name, product_name, deployment_name, params, %Auth{} = auth) do
    params = %{deployment: params}
    NervesHubCore.request(:put, path(org_name, product_name, deployment_name), params, auth)
  end

  @doc false
  @spec path(atom() | binary(), atom() | binary()) :: binary()
  def path(org_name, product_name) do
    Path.join(Product.path(org_name, product_name), @path)
  end

  @doc false
  @spec path(atom() | binary(), atom() | binary(), atom() | binary()) :: binary()
  def path(org_name, product_name, deployment_name) do
    Path.join(path(org_name, product_name), deployment_name)
  end
end
