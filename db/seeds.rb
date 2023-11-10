# Admin.create!(
#     email: 'admin@admin',
#     password: 'aaaaaa'
#     )

admins = [
    {email: 'admin@admin', password: 'aaaaaa'},
]

admins.each do |admin|
    # ref: https://railsdoc.com/page/find_or_create_by
    Admin.find_or_create_by(email: admin[:email]) do |a|
        a.password = admin[:password]
    end
end