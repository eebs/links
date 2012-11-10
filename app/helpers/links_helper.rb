module LinksHelper
  def tag_cloud(tags, classes)
      tags = tags.all if tags.respond_to?(:all)

      return [] if tags.empty?

      max_count = tags.sort_by(&:count).last.count.to_f

      tags.sort! {|a,b| a.name <=> b.name }

      tags.each do |tag|
        index = ((tag.count / max_count) * (classes.size - 1))
        yield tag, classes[index.nan? ? 0 : index.round]
      end
    end
end
