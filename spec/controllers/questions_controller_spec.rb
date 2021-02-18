require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'Get #show' do
    it 'renders show view' do
      get :show, params: { id: question }
      expect(response).to render_template :show
    end
  end

  describe 'Get #new' do
    context 'Authorized user' do
      it 'renders new view' do
        login(user)
        get :new
        expect(response).to render_template :new
      end
    end

    context 'Unauthorized user' do
      it 'renders sign in view' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'Get #edit' do
    context 'Authorized author' do
      it 'renders create view' do
        login(question.user)
        get :edit, params: { id: question }
        expect(response).to render_template :edit
      end
    end

    context 'Authorized user' do
      it 'renders show view' do
        login(user)
        get :edit, params: { id: question }
        expect(response).to render_template :show
      end
    end

    context 'Unauthorized user' do
      it 'renders sign in view' do
        get :edit, params: { id: question }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'Authorized user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new question in database' do
          expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to redirect_to assigns(:question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect do
            post :create, params: { question: attributes_for(:question, :invalid) }
          end.to_not change(Question, :count)
        end

        it 're-renders new view' do
          post :create, params: { question: attributes_for(:question, :invalid) }
          expect(response).to render_template :new
        end
      end
    end

    context 'Unauthorized user' do
      context 'with valid attributes' do
        it 'not saves a new question in database' do
          expect { post :create, params: { question: attributes_for(:question) } }.to_not change(Question, :count)
        end

        it 'redirects to sign in view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question in database' do
          expect do
            post :create, params: { question: attributes_for(:question, :invalid) }
          end.to_not change(Question, :count)
        end

        it 'redirects to sign in view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authorized author' do
      before { login(question.user) }

      context 'with valid attributes' do
        it 'assings requested questions to @question' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(assigns(:question)).to eq question
        end

        it 'change question attributes' do
          patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }
          question.reload

          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'redirects to updated question show view' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(response).to redirect_to question
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) } }

        it 'does not change question' do
          question.reload

          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end

        it 're-renders edit view' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'Authorized user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'not change question attributes' do
          patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }
          question.reload

          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end

        it 'redirects to show view' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(response).to render_template :show
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) } }

        it 'does not change question' do
          question.reload

          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end

        it 'redirects to show view' do
          expect(response).to render_template :show
        end
      end
    end

    context 'Unauthorized user' do
      it 'redirects to sign in view' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Authorized author' do
      before { login(question.user) }

      it 'deletes the question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to questions' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'Authorized user' do
      before { login(user) }
      let!(:question) { create(:question) }

      it 'not deletes the question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end

      it 'redirects to questions' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'Unauthorized user' do
      let!(:question) { create(:question) }

      it 'not deletes the question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end

      it 'redirects to sign in' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
