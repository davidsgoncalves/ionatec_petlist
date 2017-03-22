'use strict';

import React from 'react';
import Filters from './filters'
import TableComponent from './table_component'
import {Row} from 'react-bootstrap'
import PaginationComponent from './pagination_component'
const url = require('url');

const PageIndex = React.createClass({
    changePage(params = {}) {
        let propParams = this.props.params;
        Object.assign(propParams, params);
        window.location = url.format({ pathname: this.props.path, query: propParams});
    },

    render() {
        return (
            <div>
                <div className="container form-body">
                    <Filters breeds={this.props.breeds} path={this.props.path} token={this.props.token} params={this.props.params}/>
                </div>
                <div className="container form-body">
                    <TableComponent dogs={this.props.dogs}/>
                </div>
                <div className="container form-body">
                    <PaginationComponent onSelect={this.changePage} page={parseInt(this.props.page) || 1} pageSize={15}
                                         total={this.props.total} label="Cachorros"/>
                </div>
            </div>
        );
    }
});

export default PageIndex