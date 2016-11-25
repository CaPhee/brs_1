class BooksController < ApplicationController

  def index
    @books = Book.search(params[:key]).of_category(params[:category_id]).page params[:page]
    @categories = Category.all
    if user_signed_in?
      @reading_books = current_user.books.reading
      @read_books = current_user.books.read
    end
  end

  def show
    @book = Book.find_by id: params[:id]
    if @book
      @review = Review.new book_id: @book.id
      @reviews = @book.reviews.page(params[:page])
        .per Settings.book.per_page_review
    else
      flash[:danger] = t :not_fould, objectClass: Book.name
      redirect_to root_url
    end
  end
end
