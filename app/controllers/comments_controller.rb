class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @publication = Publication.find(params[:publication_id])
    @comment = @publication.comments.build(comment_params)
    if user_signed_in?
      @comment.user = current_user
    else
      # Crea un usuario anónimo o usa uno existente para representar a los usuarios no autenticados.
      # Usamos un correo electrónico ficticio y una contraseña aleatoria.
      anonymous_user = User.find_or_create_by(email: 'anonimo@example.com') do |user|
        user.password = Devise.friendly_token[0, 20]  # Genera una contraseña aleatoria para el usuario anónimo
      end
      @comment.user = anonymous_user
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @publication, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @publication }
      else
        Rails.logger.debug("Error al guardar el comentario: #{@comment.errors.full_messages}")
        format.html { render template: 'publications/show' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to publication_path(@comment.publication), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to publication_path(@comment.publication), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content, :user_id, :publication_id)
  end
end