$(function() {
    $('[data-channel-subscribe="company"]').each(function(index, element) {
        var $element = $(element),
            company_id = $element.data('company-id')
        commentTemplate = $('[data-role="comment-template"]');

        App.cable.subscriptions.create(
            {
                channel: "CompanyChannel",
                company_id: company_id
            },
            {
                received: function(data) {
                    var content = commentTemplate.children().clone(true, true);
                    content.find('[data-role="username"]').text(data.username);
                    content.find('[data-role="comment-content"]').text(data.content);
                    content.find('[data-role="comment-date"]').text(data.updated_at);
                    $element.append(content);
                    $("html, body").animate({ scrollTop: $(document).height()-$(window).height() });
                }
            }
        );
    });
});
