# Review Code Result 20200909
---

1. Đừng commit những files/methods ko xài tới làm source code nhìn nó rối.

    - app/assets/stylesheets/albums.scss

    - app/assets/stylesheets/home.scss

    - Đống file trong `public/uploads`, `public/packs` cũng ko dc upload lên, người khác ko cần xài nó lại còn làm nặng thêm source code. Source code mới viết dc mấy dòng mà đã nặng hơn 50 MBs!

    - etc.

2. Style của code chưa đẹp, chưa dễ đọc

    - Nên có 1 blank line giữa 2 method chỗ dễ nhìn

3. Ứng dụng bảo mật quá kém, chẳng thấy tác dụng định danh nằm ở đâu, cũng chẳng thấy phân quyền. Ví dụ:

    - app/controllers/albums_controller.rb#new/create: Album khi new/create thì phải là cho thằng user đang login vào hệ thống chứ sao lại cho người dùng truyền `user_id` lên như vậy. Chuyện này gây ra lỗ hổng rất lớn, user có thể dễ dàng inspect html và chèn ID của user khác vào, như vậy anh ko có username/password account của em nhưng anh hoàn toàn có thể tạo ra 1 album dưới danh nghĩa là em! Đúng ra khi new/create album thì đại loại phải vầy `current_user.albums.new(...)`. Như vậy thì album khi khởi tạo sẽ dc tự động assign `user_id` = ID của `current_user`

    - app/controllers/albums_controller.rb#edit/update: khúc này cũng có lổ hổng lớn luôn, nếu chỉ tìm album để update dựa vào ID không thôi thì anh hoàn toàn có thể ko login mà edit dc album của em dù ko có account của em. Anh chỉ việc thay id trên thanh địa chỉ browser thành ID album của người khác rồi xong. Khúc này đúng ra cần: `current_user.albums.find(...)`

    - Controller Photo cũng bị y hệt, còn nặng hơn là bên Photo có destroy, vậy thì user khác còn có thể destroy photo của em nữa cơ.

    - Việc follow cũng đang trớt quớt, với cách implement hiện tại anh có thể dễ dàng follow và unfollow 1 user dưới danh nghĩa account của em

4. Routes define chưa tốt. Việc cố gắng dùng nested resources cho `users` và nhét 1 mớ thứ vào resource `users` làm cho controller rối, phải xử lý quá nhiều chuyện. Resource user chỉ nên có như sau

```
resources :users, only: :show do
  resources :photos, :albums, only: :index
end
```

Mấy thứ khác nên move hết ra ngoài

5. Việc lấy data lên trang feed ko ổn (app/controllers/users_controller.rb#feed). Data khi pull từ database lên là phải query những gì thuộc về user mình đang follow rồi chứ ko phải lấy lên rồi đem vào view chạy vòng lặp mới kiếm tra xem Photo/Album có thuộc về thằng mình follow ko để render ra. Làm như vậy sẽ có 2 issue

    - Tạo ra quá nhiều query xuống database để kiểm ra. Khi lập trình cần luôn phải tìm mọi cách tránh né việc query database trong vòng lặp nếu có thể

    - Làm cho tính năng phân trang sau này chạy ko đúng. Giả sử mỗi lần hiển thị 1 trang thì sẽ hiển thị 20 items,  pull data từ DB mà ko filter luôn thì lấy dc 20 items, rồi khi render mới check 20 items đó thằng nào phù hợp thì trường hợp thằng OK thằng ko thì view sẽ hiện ra ko đủ 20 items, vậy là việc phân trang chạy lộn xộn rồi



6. Javascript cần gom hết vào 1 file `application.js` thôi để khi chạy production thì performance sẽ tốt hơn.

7. Association khia báo chưa hợp lý

    - Album `belongs_to :user` sao lại để optional? 1 Album chắc chắn phải có 1 user tạo ra chứ ko ko sao tự nhiên sinh ra dc!

    - Album sao `has_and_belongs_to_many :photos` được. Photo upload cho album này chỉ thuộc về album đó thôi. Requirement của app làm gì có tính năng chọn Photo từ album này copy vào album khác mà 1 Photo thuộc nhiều album dc.

    - Photo cũng bị vấn đề y hệt Album

8. Khi viết code tránh mấy dùng từ khoá đặc biệt của ngôn ngữ rđể naming. Ví dụ: `scope :sharing_mode, ->(public)` => ko nên sử dụng `public`, trường hợp này argument nên name là `mode` chẳng hạn

9. Code dư thừa, ko nên có

    - app/models/album.rb#likes_count: đối với column counter cache thì khi tạo migration cho nó default = 0 luôn để tránh vấn đề `nil`

    - Photo y hệt luôn

10. Khi khai báo 1 association polymorphic thì tên association nên kết thúc = `able`. Đây là 1 practice để khi các Rails dev khác nhìn vào code là biết association đó là polymorphic. Ví dụ `@like.contentable` => Rails dev nhìn vào là biết `contentable` là 1 association polymorphic của `Like` mà ko cần mở code model Like ra xem.

11. Method viết phức tạp hơn mức cần thiết

```
# app/models/user.rb#name/avatar_name như sau là đủ

def name
[firstname, lastname].select(&:present?).join(' ')
end

def avatar_name
[firstname.chars.first, lastname.chars.first].compact.join
end
```

12. Đã train SLIM rồi thì view prefer viết = SLIM hơn là ERB
