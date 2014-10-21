class DocumentsController < ApplicationController
  def index
  end

  def create
    redirect_to documents_path if document_params[:content].blank?

    @document = VersionedMap.new
    @document.set(:content, params[:content])
    @document.save

    redirect_to document_path(@document.token)
  end

  def version
    @document = document.get_version(params[:version].to_i)
    render template: "documents/show"
  end

  def show
    @document = document
  end

  def update
    @document = document
    @document.set(:content, params[:content])

    path = case params[:commit]
           when "保存当前版本"
             @document.update
             version_document_path(@document.token, @document.max_version)
           when "另存新档"
             @document.save
             document_path(@document.token)
           end

    redirect_to path
  end

  def document_params
    params.permit(:content)
  end

  def document
    VersionedMap.find(params[:id])
  end
end
