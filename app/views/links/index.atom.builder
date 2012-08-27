atom_feed do |feed|
    feed.title "RememberabURL"
    feed.updated @links.maximum(:updated_at)

    @links.each do |link|
        feed.entry link, url: link.url, published: link.created_at do |entry|
            entry.title link.title
            entry.content link.description
            if(link.user && link.user.displayname?)
                entry.author do |author|
                    author.name link.user.displayname
                end
            end
        end
    end
end