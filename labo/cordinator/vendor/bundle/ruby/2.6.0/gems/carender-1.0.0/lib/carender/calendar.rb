require 'date'
require 'active_support/core_ext/date'
require 'active_support/core_ext/time'

module Carender
  class Calendar
    def initialize(year, month)
      @year = year
      @month = month
    end

    def render(view_context, collection, &block)
      html = <<-HTML
        <table>
          <tr>
            <th>Sun</th>
            <th>Mon</th>
            <th>Tue</th>
            <th>Wed</th>
            <th>Thu</th>
            <th>Fri</th>
            <th>Sat</th>
          </tr>
      HTML

      (date..date.end_of_month).each do |d|
        if d.wday == 0 || (d == date && d.wday != 0)
          html += '<tr>'
        end

        if d == date
          d.wday.times { html += '<td></td>' }
        end

        html += '<td>'

        if block
          html += view_context.capture { block.call(d, collection[d]) }.to_s
        end

        html += '</td>'

        if d == date.end_of_month
          (6 - d.wday).times { html += '<td></td>' }
        end

        if d.wday == 6 || (d == date.end_of_month && d.wday != 6)
          html += '</tr>'
        end
      end

      html += '</table>'
      html
    end

    private

    attr_reader :year, :month

    def date
      @date ||= Date.new(year, month)
    end
  end
end
