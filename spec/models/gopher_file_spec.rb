require "rails_helper"

RSpec.describe GopherFile do
  describe ".content" do
    context "when the file is a text file" do
      subject(:gopher_file) do
        described_class.new(
          filetype: "0",
          selector: "this/is/a/test.txt",
          resource: "This is the content of the file"
        )
      end

      it "returns the text content" do
        expect(gopher_file.mime_type).to eq("text/plain")
        expect(gopher_file.content).to eq("This is the content of the file")
      end
    end

    context "when the file is an image file" do
      subject(:gopher_file) do
        described_class.new(
          filetype: "p",
          selector: "this/is/a/test.png",
          resource: Rails.root.join("spec/fixtures/files/test.png").read
        )
      end

      it "returns the image content" do
        expect(gopher_file.mime_type).to eq("image/png")
        expect(gopher_file.content).to eq(Rails.root.join("spec/fixtures/files/test.png").read)
      end
    end

    context "when the file is an image file and INLINE_IMAGES is true" do
      subject(:gopher_file) do
        described_class.new(
          filetype: "p",
          selector: "this/is/a/test.png",
          resource: Rails.root.join("spec/fixtures/files/test.png").read
        )
      end

      before do
        allow(ENV).to receive(:fetch).with("INLINE_IMAGES", "false").and_return("true")
      end

      it "returns the image content as a Base64 string" do
        expect(gopher_file.content).to eq(Base64.encode64(Rails.root.join("spec/fixtures/files/test.png").read))
      end
    end

    context "when the file is not a text or image file" do
      subject(:gopher_file) do
        described_class.new(
          filetype: ";",
          selector: "this/is/a/test.avi",
          resource: Rails.root.join("spec/fixtures/files/test.avi").read
        )
      end

      it "returns the file content" do
        expect(gopher_file.mime_type).to eq("video/x-msvideo")
        expect(gopher_file.content).to eq(
          Rails.root.join("spec/fixtures/files/test.avi").read.force_encoding("ASCII-8BIT")
        )
      end
    end
  end
end
