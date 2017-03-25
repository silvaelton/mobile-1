require_dependency 'attendance/application_controller'

module Attendance
  class DocumentsController < ApplicationController
      
    before_action :set_cadastre
    before_action :set_ticket
    before_action :set_action 

    def new      
      @action   = Core::Attendance::ActionDocumentForm.find(@action.id)
      
      @service  = Core::Attendance::DocumentService.new(cadastre: @cadastre,
                                                        action: @action,
                                                        ticket: @ticket) 
      
      @service.documents_required!

      @action = @service.action
    end

    def create
      if @action.update(set_params)
        @service = Core::Attendance::TicketService.new(cadastre: @cadastre, ticket: @ticket, action: @action)
        @service.close_action

        redirect_to new_ticket_path
      else
        render action: :new
      end

    end

    private

    def set_params
      params.fetch(:attendance_action_document_form, {})
            .permit(
              certificate_born_documents: [:id, :_destroy, :document],
              income_documents_attributes: [:id, :_destroy, :document],
              rg_documents: [:id, :_destroy, :document],
              cpf_documents: [:id, :_destroy, :document],
              residence_documents: [:id, :_destroy, :document],
              arrival_df_documents: [:id, :_destroy, :document],
              registry_documents: [:id, :_destroy, :document],
              payment_documents: [:id, :_destroy, :document],
              income_documents: [:id, :_destroy, :document],
              special_condition_documents: [:id, :_destroy, :document],
              )
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_ticket
      @ticket   = @cadastre.tickets.find(params[:ticket_id]) 
    end

    def set_action
      @action   = @ticket.actions.find(params[:action_id])
    end
  end
end