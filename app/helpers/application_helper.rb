module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.update "flash", partial: "layouts/flash"
  end
end
