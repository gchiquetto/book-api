module Api
    module V1
        class BooksController < ApplicationController
            ALLOWED_DATA = %[title description author rating].freeze
            def index
                books = Book.all
                render json: books
            end

            def show
                book = Book.find(params[:id])
                render json: book, status: :ok
            end

            def create 
                data = json_payload.select{|k| ALLOWED_DATA.include? k}
                book = Book.new(data) 
                if book.save
                    render json: book, status: :created
                else
                    render json: {"error": "wasn't possible to create it"}, status: :unprocessable_entity
                end
            end

            def update
                book = Book.find(params[:id])
                data = json_payload.select{|k| ALLOWED_DATA.include? k}
                if book.update(data)
                    render json: book
                else
                    render json: {"error": "wasn't possible to update it"}, status: :unprocessable_entity
                end
            end

            def destroy
                book = Book.find(params[:id])
                book.destroy
                render status: :see_other
            end
        end
    end
end