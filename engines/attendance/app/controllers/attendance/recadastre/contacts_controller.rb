require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class ContactsController < ApplicationController
      
      before_action :set_ticket
      before_action :set_context
      before_action :set_cadastre_mirror, only: [:show, :edit, :update]

      def confirm
        @context.update(status: 'finalizado')
        
        redirect_to recadastre_ticket_contexts_path(@ticket)
      end

      def index
        @cadastre_mirror = @ticket.cadastre_mirror
      end

      private

      def set_params
        params.require(:attendance_cadastre_form).permit(:rg)
      end

      def set_cadastre_mirror
        @cadastre_mirror = Core::Attendance::CadastreForm.find(@ticket.cadastre_mirror_id)
      end

      def set_context
        @context = Core::Attendance::TicketContextAction.find(params[:context_id])
      end

      def set_ticket
        @ticket = current_cadastre.tickets.find(params[:ticket_id])
        @ticket = Core::Attendance::TicketPolicy.new(@ticket)
        @ticket = Core::Attendance::TicketPresenter.new(@ticket)
      end


    end
  end
end