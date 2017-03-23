require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class IncomesController < ApplicationController
      
      before_action :set_ticket

      def context_new
        @service = Core::Attendance::RecadastreService.new(ticket: @ticket)
        @service.create_context 3

        redirect_to recadastre_ticket_income_path(ticket_id: @ticket.id, id: @ticket.cadastre_mirror_id)
      end

      def confirm
        @service = Core::Attendance::RecadastreService.new(ticket: @ticket)
        @service.confirm_by_context 3

        redirect_to recadastre_tickets_path
      end

      def show
        @cadastre_mirror = @ticket.cadastre_mirror
      end

      def edit
        @cadastre_mirror = Core::Attendance::IncomeForm.find(@ticket.cadastre_mirror_id)
      end

      def update
        @cadastre_mirror = Core::Attendance::IncomeForm.find(@ticket.cadastre_mirror_id)
        
        if @cadastre_mirror.update(set_params)
          redirect_to edit_recadastre_ticket_context_document_path(ticket_id: @ticket, context_id: 3, id: @cadastre_mirror)
        else
          render action: :edit
        end
      end

      private

      def set_params
        params.require(:attendance_cadastre_form).permit(:rg, :gender, :born, :born_uf, :rg_org, :rg_uf, 
                                                         :place_birth, :mother_name, :special_condition_id,
                                                         :special_condition_type_id, :nis, :cid, :adapted_property)
      end

      def set_ticket
        @ticket = current_cadastre.tickets.find(params[:ticket_id])
        @ticket = Core::Attendance::TicketPolicy.new(@ticket)
      end

    end
  end
end