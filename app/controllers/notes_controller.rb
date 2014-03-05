class NotesController < ApplicationController
  before_filter :require_login

  def create
    @member = Member.find(params[:member_id])
    @note = @member.notes.build(note_params)
    if @note.save
      redirect_to_referer_or members_path
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to_referer_or members_path
  end

  private
  def note_params
    params.require(:note).permit(:message)
  end
end
